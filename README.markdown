<div align="center">

![🚧 Under construction 👷‍♂️](https://i.imgur.com/LEP2R3N.png)

</div>

# `llvm-box`

📦 A single WebAssembly binary of all the LLVM infrastructure & commands \
🔀 Forked from [llvm/llvm-project]

<div align="center">

![]()

</div>

🎁 Nice compact WASM bundle \
🗃️ Avoids repeated code across multiple binaries \
🖥️ Works with [WASI]

🌐 Wan't a convenient API to compile C++ code right from your browser? Check
out the mother [Emception] project!

❓ Want to learn more about [BusyBox]? Check out their [What is Busybox?] FAQ!

## Development

⚠️ This repository is a [fork]! We try to change as little as possible to make
keeping on-top of upstream changes as easy as possible. For instance, this means
**not** running custom code formatters, **not** customizing names unless needed,
and generally **not** touching anything that isn't needed.

🔃 Every so often, we will merge upstream changes back into this fork to keep
up-to-date with the latest and greatest LLVM code. We just need to make sure it
works with Emscripten and compiles to WASM! 😉

This project uses devcontainers to configure the development environment. You
can get started by opening this repo in [GitHub Codespaces] right from your
browser!

### Building the project

📜 For more information about how LLVM works, how to build it, etc. you can
check out the original [`README.md`] that has been left untouched.

The gist is that you can run the following command sequence on **Linux/WSL2** to
get a successful build:

```sh
mkdir -p build
cmake -S llvm -B build -G Ninja # UNVERIFIED
```

### Changes from LLVM upstream

Since we need to do some additional build stuff, we have made _some_ changes. In
order to make everyone's lives easier, it's helpful to describe those changes
here _in addition to describing them in commits and PRs_.

1. Added a `README.markdown` file which is alphabetically sorted to override the
    original `README.md` file. This was done to emphasize that this project is
    _not intended to merge with upstream_ and to describe the project.
2. Removed the `.github/PULL_REQUEST_TEMPLATE.md` which warned against opening
    PRs. LLVM had their own custom code merge process, but here we just use
    GitHub's system.

<!-- prettier-ignore-start -->
[BusyBox]: https://busybox.net/
[What is Busybox?]: https://busybox.net/FAQ.html#whatis
[llvm/llvm-project]: https://github.com/llvm/llvm-project#readme
[`README.md`]: README.md
[fork]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks
[GitHub Codespaces]: https://github.com/features/codespaces
[WASI]: https://wasi.dev/
[Emception]: https://github.com/jcbhmr/emception#readme
<!-- prettier-ignore-end -->
