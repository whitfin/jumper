defmodule Jumper do
  @moduledoc """
  Jump consistent hashing for Elixir, without the need of C compilers.

  This module exposes nothing beyond a simple `slot/2`, used to slot a key into a
  ange of buckets `[0, buckets)`. This offers a fairly good consistency rate with
  changing bucket counts, such that:

      iex> Jumper.slot(5000, 10)
      4
      iex> Jumper.slot(5000, 11)
      4
      iex> Jumper.slot(5000, 12)
      4

  This can be used for routing inside systems where destinations change often and
  can come and go (so there's a variable number of destinations). This is the main
  advantage; static destination counts can simply `hash(key) % N` as a router.

  This implementation is based on the algorithm described in the original paper
  found [here](https://arxiv.org/ftp/arxiv/papers/1406/1406.2294.pdf).
  """
  use Bitwise

  # the jump count
  @jump 1 <<< 31

  # magic number use for jumping
  @mage 0x27BB2EE687B0B0FD

  # a 64 bit mask for wrapping
  @mask 0xFFFFFFFFFFFFFFFF

  @doc """
  Slots a key into a range of buckets of the form `[0, buckets)`.

  The key and bucket count must both be integers; to slot a non-numeric value,
  it's possible to use `:erlang.phash2/1` to generate a quick hash value.

  ## Examples

      iex> Jumper.slot(5000, 10)
      4
      iex> Jumper.slot(5000, 11)
      4
      iex> Jumper.slot(5000, 12)
      4
  """
  @spec slot(key :: integer, buckets :: integer) :: integer
  def slot(key, buckets) when is_integer(key) and is_integer(buckets),
    do: jump_consistent_hash(key, buckets, -1, 0)

  # Recursive jump consistent hash algorithm, using guards to determine when the
  # algorithm has completed. Nothing special to see here beyond the algorithm as
  # defined in the paper released by Google (see module documentation for links).
  defp jump_consistent_hash(key, buckets, _bucket, j) when j < buckets do
    new_key = key * @mage + 1 &&& @mask
    new_jump = trunc((j + 1) * (@jump / ((new_key >>> 33) + 1)))
    jump_consistent_hash(new_key, buckets, j, new_jump)
  end

  # Exit clause for jump hashing, which just emits the bucket
  defp jump_consistent_hash(_key, _buckets, bucket, _j), do: bucket
end
