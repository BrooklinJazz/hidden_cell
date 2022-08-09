defmodule HiddenCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Hidden Cell"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""
    {:ok, assign(ctx, source: source)}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{source: ctx.assigns.source}, ctx}
  end

  @impl true
  def handle_event("update", %{"source" => source}, ctx) do
    broadcast_event(ctx, "update", %{"source" => source})
    {:noreply, assign(ctx, source: source)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"source" => ctx.assigns.source}
  end

  @impl true
  def to_source(attrs) do
    attrs["source"]
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      ctx.root.innerHTML = `
        <section id="container">
          <p id="title">Hidden Cell</p>
          <textarea id="source"></textarea>
        </section>
      `;

      const textarea = ctx.root.querySelector("#source");
      const title = ctx.root.querySelector("#title");
      const container = ctx.root.querySelector("#container");

      textarea.style.display = "none"
      textarea.value = payload.source;

      textarea.addEventListener("change", (event) => {
        ctx.pushEvent("update", { source: event.target.value });
      });

      title.addEventListener("dblclick", (event) => {
        if (textarea.style.display == "none") {
          textarea.style.display = "block"
        } else {
          textarea.style.display = "none"
        }
      });

      ctx.handleEvent("update", ({ source }) => {
        textarea.value = source;
      });

      ctx.handleSync(() => {
        // Synchronously invokes change listeners
        document.activeElement &&
          document.activeElement.dispatchEvent(new Event("change"));
      });
    }
    """
  end

  asset "main.css" do
    """
    #source {
      box-sizing: border-box;
      width: 100%;
      min-height: 100px;
    }

    #container {
      padding: 0.3rem;
      background-color: rgb(240 245 249);
      border-radius: 0.5rem;
      font-weight: 500;
      color: rgb(97 117 138);
      font-family: Inter, system-ui,-apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji;
    }

    #title {
      text-align: center;
      cursor: pointer;
    }
    """
  end
end
