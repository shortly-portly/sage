defmodule SageWeb.FormatHelpers do
  use Phoenix.HTML

  def header(title, image \\ nil) do
    wrapper_opts = [class: "flex items-center justify-between py-5"]

    content_tag :div, wrapper_opts do
      text_layout =
        content_tag :div do
          content_tag :h1, class: "header" do
            title
          end
        end

      image_layout =
        content_tag :div do
          content_tag :img, src: image, alt: "foo", class: "w-40 h-40" do
          end
        end

      [text_layout, image_layout]
    end
  end
end
