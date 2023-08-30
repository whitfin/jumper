pairs = [
  {1, 1},
  {42, 57},
  {0xDEAD10CC, 1},
  {0xDEAD10CC, 666},
  {256, 1024},
  {0xA9993E364706816ABA3E25717850C26C9CD0D89D, 5}
]

benchmarks =
  Enum.reduce(pairs, %{}, fn {key, buckets}, acc ->
    Map.put(acc, "slot(#{key}, #{buckets})", fn ->
      Jumper.slot(key, buckets)
    end)
  end)

Benchee.run(benchmarks,
  formatters: [
    {
      Benchee.Formatters.Console,
      [
        comparison: false,
        extended_statistics: true
      ]
    },
    {
      Benchee.Formatters.HTML,
      [
        auto_open: false
      ]
    }
  ],
  print: [
    fast_warning: false
  ]
)
