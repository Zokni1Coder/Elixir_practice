defmodule ChatAppWeb.CustomComponents do
  use Phoenix.Component
  use ChatAppWeb, :verified_routes

  attr :current_user, :any, required: true
  attr :items, :list, required: true

  @spec custom_header(map()) :: Phoenix.LiveView.Rendered.t()
  def custom_header(assigns) do
    ~H"""
    <header class="text-white px-4 sm:px-6 lg:px-8 bg-blue-400">
      <div>
        <ul class="flex gap-3 justify-end">
          <%= for item <- Enum.filter(@items, &Map.get(&1, :show, true)) do %>
            <% link_attributes =
              if is_map_key(item, :method),
                do: %{href: item.path, method: item.method},
                else: %{navigate: item.path} %>

            <li>
              <.link
                class={[
                  "text-[0.8125rem] leading-6 font-semibold px-2 py-3 hover:text-zinc-700 inline-block",
                  if(item.path == Map.get(@current_uri, :path),
                    do: "bg-blue-600 hover:bg-blue-200",
                    else: "hover:bg-blue-400"
                  )
                ]}
                {link_attributes}
              >
                <%= item.label %>
              </.link>
            </li>
          <% end %>
          <%= if @current_user do %>
            <li class="text-[0.8125rem] leading-6 font-semibold px-2 py-3 inline-block">
              <%= @current_user.email %>
            </li>
          <% end %>
        </ul>
      </div>
    </header>
    """
  end
end
