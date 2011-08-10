if defined?(ActionView) && defined?(ActionView::Template)
  ActionView::Template.class_eval do

    #stub out old api from rails2
    def render_template(*args, &block)
    end
    def render_template_with_rack_bug(*args, &block)
      Rack::Bug::TemplatesPanel.record(path_without_format_and_extension) do
        render_template_without_rack_bug(*args, &block)
      end
    end
    alias_method_chain :render_template, :rack_bug

    # rails3 api
    def render_with_rack_bug(*args, &block)
      Rack::Bug::TemplatesPanel.record(@virtual_path) do
        render_without_rack_bug(*args, &block)
      end
    end
    alias_method_chain :render, :rack_bug
  end
end

