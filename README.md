# Jumper
[![Coverage Status](https://img.shields.io/coveralls/whitfin/jumper.svg)](https://coveralls.io/github/whitfin/jumper) [![Unix Build Status](https://img.shields.io/travis/whitfin/jumper.svg?label=unix)](https://travis-ci.org/whitfin/jumper) [![Windows Build Status](https://img.shields.io/appveyor/ci/whitfin/jumper.svg?label=win)](https://ci.appveyor.com/project/whitfin/jumper) [![Hex.pm Version](https://img.shields.io/hexpm/v/jumper.svg)](https://hex.pm/packages/jumper) [![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://hexdocs.pm/jumper/)

### Installation

Jumper is available on [Hex](https://hex.pm/). You can install the package by adding it to your dependencies in `mix.exs`:

 ```elixir
def deps do
  [{:jumper, "~> 1.0"}]
end
```

### Usage

Using Jumper is pretty trivial; there is a single API used to slot keys into a range of buckets:

```elixir
iex> Jumper.slot(256, 1024)
520
```

The first argument is the key, and the second is the number of buckets the key can be slotted into. The result is the bucket the key should be routed to. Both the key and the bucket count should be valid integers. If you want to check a non-integer key, you could always use `:erlang.phash2/1` to generate a hash code for the value:

```elixir
iex> %{} |> :erlang.phash2 |> Jumper.slot(1024)
29
```

### Benchmarks

There are some very trivial benchmarks available using [Benchee](https://github.com/PragTob/benchee) in the `benchmarks/` directory. You can run the benchmarks using the following command:

```bash
$ mix bench
```

Typical results are a microsecond or two, based on the number of buckets you're trying to slot into (scales to the number of buckets).

### Contributions

If you feel something can be improved, or have any questions about certain behaviours or pieces of implementation, please feel free to file an issue. Proposed changes should be taken to issues before any PRs to avoid wasting time on code which might not be merged upstream.

If you *do* make changes to the codebase, please make sure you test your changes thoroughly, and include any unit tests alongside new or changed behaviours. Cachex currently uses the excellent [excoveralls](https://github.com/parroty/excoveralls) to track code coverage.

```bash
$ mix test
$ mix credo
$ mix coveralls
$ mix coveralls.html && open cover/excoveralls.html
```
