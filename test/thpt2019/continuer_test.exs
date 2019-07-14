defmodule Thpt2019.ContinuerTest do
  use ExUnit.Case
  doctest Thpt2019.Continuer
  alias Thpt2019.Continuer

  test "run Continuer" do
    Continuer.start_link([])
    Continuer.failed()
    Continuer.failed()
    Continuer.failed()

    assert Continuer.get_counter() == 3

    Continuer.reset()
    assert Continuer.get_counter() == 0

    Continuer.failed()
    Continuer.failed()
    assert Continuer.get_counter() == 2

    Continuer.stop()
  end
end
