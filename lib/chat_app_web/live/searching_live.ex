defmodule ChatAppWeb.SearchingLive do
  use ChatAppWeb, :live_view

  def mount(_params, _, socket) do
    socket =
      assign(socket,
        list: [
          %{name: "erik", age: 24, date_of_birth: ~D[2000-09-22]},
          %{name: "fabi", age: 24, date_of_birth: ~D[2000-07-09]},
          %{name: "bundas", age: 24, date_of_birth: ~D[2000-05-27]},
          %{name: "reka", age: 19, date_of_birth: ~D[2005-05-18]},
          %{name: "sara", age: 20, date_of_birth: ~D[2004-06-16]}
        ],
        searched_list: [],
        form: to_form(%{}, as: "search")
      )

    {:ok, socket}
  end

  def handle_event("search", %{"search" => %{"name" => ""}}, socket) do
    socket = assign(socket, searched_list: [])
    {:noreply, socket}
  end

  def handle_event("search", params, socket) do
    # IO.inspect(params, label: "params")
    # IO.inspect(params["search"], label: "params[\"search\"]")
    socket =
      assign(socket,
        searched_list:
          Enum.filter(socket.assigns.list, &String.contains?(&1.name, params["search"]["name"]))
      )

    IO.inspect(socket.assigns.searched_list)
    {:noreply, socket}
  end
end
