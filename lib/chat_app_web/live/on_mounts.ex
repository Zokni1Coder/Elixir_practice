defmodule ChatAppWeb.OnMounts do
  import Phoenix.LiveView, only: [attach_hook: 4]
  import Phoenix.Component, only: [assign: 2]

  def on_mount(:default, _params, _session, socket) do
    socket =
      attach_hook(socket, :fetch_current_uri, :handle_params, fn
        _params, uri, socket ->
          socket = assign(socket, current_uri: URI.parse(uri))
          {:cont, socket}
      end)

    {:cont, socket}
  end
end
