defmodule ChatAppWeb.CustomComponents do
  use Phoenix.Component
  use ChatAppWeb, :verified_routes

  attr :current_user, :any, required: true
  attr :items, :list, required: true

  def custom_header(assigns) do
    ~H"""
    <header class="text-white px-4 sm:px-6 lg:px-8 bg-blue-400">
      <div>
        <ul class="flex gap-3 justify-end">
          <%= for item <- Enum.filter(@items, &Map.get(&1, :show, true)) do %>
            <li>
              <.link
                navigate={item.path}
                class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
              >
                <%= item.label %>
              </.link>
            </li>
          <% end %>
          <%!-- <li>
            <.link
              navigate={~p"/searching"}
              class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
            >
              Kereső
            </.link>
          </li>
          <li>
            <.link
              navigate={~p"/light"}
              class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
            >
              Lámpa kapcsoló
            </.link>
          </li>
          <li>
            <.link
              navigate={~p"/pagination"}
              class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
            >
              Paginator + Rendezés
            </.link>
          </li>
          <%= if @current_user do %>
            <li class="text-[0.8125rem] leading-6">
              <%= @current_user.email %>
            </li>
            <li>
              <.link
                href={~p"/users/settings"}
                class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
              >
                Settings
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
              >
                Log out
              </.link>
            </li>
          <% else %>
            <li>
              <.link
                href={~p"/users/register"}
                class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
              >
                Register
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_in"}
                class="text-[0.8125rem] leading-6 font-semibold hover:bg-blue-200 px-2 py-3 hover:text-zinc-700 inline-block"
              >
                Log in
              </.link>
            </li>
          <% end %> --%>
        </ul>
      </div>
    </header>
    """
  end
end
