defmodule ChatAppWeb.UploadLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_profiles, [])
     |> allow_upload(:profile, accept: [".jpg", ".jpeg", ".gif", ".png"], max_entries: 1)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :profile, ref)}
  end

  def handle_event("save", _params, socket) do
    uploaded_profiles =
      consume_uploaded_entries(socket, :profile, fn %{path: path}, _entry ->
        dest =
          Path.join(Application.app_dir(:chat_app, "priv/static/uploads"), Path.basename(path))

        File.cp!(path, dest)
        {:ok, ~p"/uploads/#{Path.basename(dest)}"}
      end)

    # IO.inspect(uploaded_profiles)
    {:noreply, update(socket, :uploaded_profiles, &(&1 ++ uploaded_profiles))}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
end
