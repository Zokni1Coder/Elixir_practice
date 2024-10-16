defmodule ChatAppWeb.PaginationLive do
  use ChatAppWeb, :live_view
  # modul attribute
  @list [
    %{name: "erik", date_of_birth: ~D[2000-09-22]},
    %{name: "fabi", date_of_birth: ~D[2000-07-09]},
    %{name: "bundas", date_of_birth: ~D[2000-05-27]},
    %{name: "reka", date_of_birth: ~D[2005-05-18]},
    %{name: "sara", date_of_birth: ~D[2004-06-16]},
    %{name: "niki", date_of_birth: ~D[1996-09-17]},
    %{name: "jozsef", date_of_birth: ~D[1968-10-03]},
    %{name: "monika", date_of_birth: ~D[1971-12-05]},
    %{name: "feri", date_of_birth: ~D[1992-12-16]},
    %{name: "pista", date_of_birth: ~D[1887-06-09]}
  ]
  @default_limit 3

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    # IO.inspect(socket)
    page_from_params = String.to_integer(params["page"] || "1")
    limit_from_params = (params["limit"] && String.to_integer(params["limit"])) || @default_limit
    page = maybe_set_page(page_from_params, limit_from_params)

    socket =
      if page_from_params == page do
        paginated_list =
          @list
          |> Enum.sort(&(Date.compare(&1.date_of_birth, &2.date_of_birth) == :lt))
          |> Enum.slice(page * limit_from_params - limit_from_params, limit_from_params)

        assign(socket,
          paginated_list: paginated_list,
          page: page,
          limit: limit_from_params,
          form: to_form(%{"limit" => limit_from_params}, as: "set_limiter"),
          max_page: max_page(limit_from_params)
        )
      else
        push_patch(socket, to: ~p"/pagination?#{%{page: page, limit: limit_from_params}}")
      end

    {:noreply, socket}
  end

  def handle_event("set_limiter", %{"set_limiter" => %{"limit" => limit}}, socket) do
    # IO.inspect(socket)
    socket = push_patch(socket, to: ~p"/pagination?#{%{page: socket.assigns.page, limit: limit}}")
    {:noreply, socket}
  end

  def maybe_set_page(page, _limit) when page < 1, do: 1

  def maybe_set_page(page, limit) do
    max_page = max_page(limit)

    if page > max_page do
      max_page
    else
      page
    end
  end

  defp max_page(limit), do: (length(@list) / limit) |> Float.ceil() |> round()
end
