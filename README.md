# HiddenCell

**A Kino Smart Cell to selectively hide Elixir Cells in Livebook**

## Installation

`HiddenCell` relies on the [Kino](https://github.com/trbflxr/kino) project. Use `Mix.install/2` in the setup section of your project to install `HiddenCell` and `Kino`.

```elixir
Mix.install([{:kino, "~> 0.6.2"}, {:hidden_cell, github: "BrooklinJazz/hidden_cell"}])
```

## Usage

Hidden Cells hide the code of an Elixir Cell when you only want to display the output.

![image](https://user-images.githubusercontent.com/14877564/183743123-bfa11b87-749f-4729-baeb-ba359e96c794.png)

Double click on the `HiddenCell` to display a textarea code editor.

![image](https://user-images.githubusercontent.com/14877564/183743199-ae0486b8-4c8b-4c17-a7e9-51a7a1bba2da.png)
