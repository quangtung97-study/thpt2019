defmodule Thpt2019 do
  @doc """
  ## Examples
      iex> Thpt2019.sbd_to_strings(4000666)
      {"04000666", "04"}
  """
  def sbd_to_strings(sbd) do
    prefix = div(sbd, 1_000_000)
    suffix = rem(sbd, 1_000_000)

    prefix = String.pad_leading("#{prefix}", 2, "0")
    suffix = String.pad_leading("#{suffix}", 6, "0")

    {"#{prefix}#{suffix}", prefix}
  end

  def get(sbd) do
    {sbd, cum} = sbd_to_strings(sbd)

    HTTPoison.get!(
      "http://diemthi.24h.com.vn/?v_page=1&v_sbd=#{sbd}&v_ten=&v_cum_thi=#{cum}&879750"
    ).body
  end

  @doc """
  ## Examples
      iex> Thpt2019.int(["0123"])
      123
  """
  def int(s) do
    with [s] <- s,
         {value, _} <- Integer.parse(s) do
      value
    else
      _ -> nil
    end
  end

  @doc """
  ## Examples
      iex> Thpt2019.decimal(["0123.22"])
      #Decimal<123.22>
  """
  def decimal(s) do
    with [s] <- s,
         {:ok, value} = Decimal.parse(s) do
      value
    else
      _ -> nil
    end
  end

  def parse(html) do
    values = Floki.find(html, "#box_tra_diem_ptth_2019 tbody>tr>td")

    if values == [] do
      %{}
    else
      {_, _, sbd} = Enum.at(values, 1)

      {_, _, toan} = Enum.at(values, 2)
      {_, _, nguvan} = Enum.at(values, 3)
      {_, _, ngoaingu} = Enum.at(values, 4)

      {_, _, vatly} = Enum.at(values, 5)
      {_, _, hoahoc} = Enum.at(values, 6)
      {_, _, sinhhoc} = Enum.at(values, 7)

      {_, _, lichsu} = Enum.at(values, 9)
      {_, _, dialy} = Enum.at(values, 10)
      {_, _, gdcd} = Enum.at(values, 11)

      %{
        sbd: int(sbd),
        toan: decimal(toan),
        nguvan: decimal(nguvan),
        ngoaingu: decimal(ngoaingu),
        vatly: decimal(vatly),
        hoahoc: decimal(hoahoc),
        sinhhoc: decimal(sinhhoc),
        lichsu: decimal(lichsu),
        dialy: decimal(dialy),
        gdcd: decimal(gdcd)
      }
    end
  end
end
