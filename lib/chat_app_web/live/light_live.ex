defmodule ChatAppWeb.LightLive do
  use ChatAppWeb, :live_view

  @min_brightness 0
  @max_brightness 100

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    # IO.inspect(socket)
    {:ok, socket}
  end

  def handle_event("rnd", _, socket) do
    socket = assign(socket, :brightness, Enum.random(@min_brightness..@max_brightness))
    {:noreply, socket}
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: @max_brightness)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: @min_brightness)
    {:noreply, socket}
  end

  def handle_event("up", _, %{assigns: %{brightness: brightness}} = socket)
      when brightness < @max_brightness do
    socket = assign(socket, brightness: maybe_set_brightness(brightness + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, %{assigns: %{brightness: brightness}} = socket)
      when brightness > @min_brightness do
    socket = assign(socket, brightness: maybe_set_brightness(brightness - 10))
    {:noreply, socket}
  end

  def handle_event(event, _, socket) when event in ["up", "down"] do
    {:noreply, socket}
  end

  defp maybe_set_brightness(brightness) when brightness < @min_brightness, do: @min_brightness
  defp maybe_set_brightness(brightness) when brightness > @max_brightness, do: @max_brightness
  defp maybe_set_brightness(brightness), do: brightness
end
