defmodule JsonApiTest do
  use ExUnit.Case
  doctest JsonApi

  test "greets the world" do
    assert JsonApi.hello() == :world
  end
end
