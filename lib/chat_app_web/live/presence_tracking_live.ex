defmodule ChatAppWeb.PresenceTrackingLive do
  use ChatAppWeb, :live_view

  alias ChatAppWeb.Presence

  def mount(params, _session, socket) do
    socket = stream(socket, :presences, [])

    socket =
      if connected?(socket) do
        Presence.track_user(params["name"], %{id: params["name"]})
        Presence.subscribe()
        stream(socket, :presences, Presence.list_online_users())
      else
        socket
      end

    {:ok, socket}
  end

  def handle_info({Presence, {:join, presence}}, socket) do
    {:noreply, stream_insert(socket, :presences, presence)}
  end

  def handle_info({Presence, {:leave, presence}}, socket) do
    if presence.metas == [] do
      {:noreply, stream_delete(socket, :presences, presence)}
    else
      {:noreply, stream_insert(socket, :presences, presence)}
    end
  end
end
