defmodule ChatAppWeb.LightLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    # IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Proch Light</h1>
    <div id="light">
      <div class="bg-gray-400 rounded-md overflow-hidden">
        <span
          style={"width: #{@brightness}%"}
          class="bg-yellow-400 py-2 inline-block text-center transition-all duration-1000"
        >
          <%= @brightness %>%
        </span>
      </div>
      <div class="flex justify-center mt-10 gap-5">
        <button class="bg-gray-200 p-2 rounded-md hover:bg-gray-300 transition" phx-click="off">
          <.icon name="hero-light-bulb-solid" class="w-10 h-10" />
        </button>
        <button class="bg-gray-200 p-2 rounded-md hover:bg-gray-300 transition" phx-click="down">
          <.icon name="hero-chevron-down" class="w-10 h-10" />
        </button>
        <button class="bg-gray-200 p-2 rounded-md hover:bg-gray-300 transition" phx-click="up">
          <.icon name="hero-chevron-up" class="w-10 h-10" />
        </button>
        <button class="bg-gray-200 p-2 rounded-md hover:bg-gray-300 transition" phx-click="on">
          <.icon name="hero-light-bulb" class="w-10 h-10 text-orange-400" />
        </button>
      </div>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end

  def handle_event("up", _, %{assigns: %{brightness: brightness}} = socket)
      when brightness < 100 do
    socket = assign(socket, brightness: brightness + 10)
    {:noreply, socket}
  end

  def handle_event("down", _, %{assigns: %{brightness: brightness}} = socket)
      when brightness > 0 do
    socket = assign(socket, brightness: brightness - 10)
    {:noreply, socket}
  end

  def handle_event(event, _, socket) when event in ["up", "down"] do
    {:noreply, socket}
  end
end
