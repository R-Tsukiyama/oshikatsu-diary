module ApplicationHelper
    def render_turbo_stream_flash_messages
        turbo_stream.prepend "flash", partial: "layouts/shared/errors"
      end
      
      def render_flash_messages
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "layouts/shared/errors")
          ]
       end
end
