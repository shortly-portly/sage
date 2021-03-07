defmodule SageWeb.InputHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    # Return the input type for the given field
    type = Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "px-3 mb-4 mt-4 md:mb-0 flex-grid"]
    label_opts = [class: "label"]
    #    input_opts = [class: "input #{state_class(form, field)}"]
    input_opts = [class: "input", "phx-debounce": "blur"]

    content_tag :div, wrapper_opts do
      label_text =
        if opts[:label_text] do
          opts[:label_text]
        else
          field
        end

      label =
        if opts[:label] == false do
          " "
        else
          label(form, field, humanize(label_text), label_opts)
        end

      input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
      error = SageWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  def date(form, field, opts \\ []) do
    type = :text_input

    wrapper_opts = [class: "px-3 mt-2 mb-2  flex-grid"]
    label_opts = [class: "label"]
    #    input_opts = [class: "input #{state_class(form, field)}"]
    input_opts = [class: "input", phx_hook: "Wobble", readonly: true]

    content_tag :div, wrapper_opts do
      label_text =
        if opts[:label_text] do
          opts[:label_text]
        else
          field
        end

      label =
        if opts[:label] == false do
          " "
        else
          label(form, field, humanize(label_text), label_opts)
        end

      input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
      error = SageWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  def my_submit(label, opts \\ []) do
    wrapper_opts = [class: "px-3 mb-8 mt-8 md:mb-0 flex-grid"]

    opts = Keyword.put_new(opts, :class, "submit")

    content_tag :div, wrapper_opts do
      Phoenix.HTML.Form.submit(label, opts)
    end
  end

  def check_box(form, field) do
    content_tag :div, class: "form-group" do
      content_tag :div, class: "form-check" do
        label = label(form, field, humanize(field), class: "form-check-label")
        input = checkbox(form, field, class: "form-check-input")
        error = SageWeb.ErrorHelpers.error_tag(form, field)

        [input, label, error || ""]
      end
    end
  end

  def bs_select(form, field, options, opts \\ []) do
    content_tag :div, class: "form-group" do
      input_opts = [class: "form-control"]
      opts = Keyword.merge(opts, input_opts)
      input = select(form, field, options, opts)
      error = SageWeb.ErrorHelpers.error_tag(form, field)

      [input, error]
    end
  end
end
