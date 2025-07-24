module Trestle
  module ActiveStorage
    class Field < Trestle::Form::Field
      def field
        instance = builder.object
        attachment = instance.send(name)

        puts "INSTANCE: #{instance.inspect}\n\n"
        puts "BUILDER: #{builder.inspect}\n\n"

        rendering_options = {}.tap do |hash|
          hash[:locals] = {}.tap do |locals|
            locals[:builder] = builder
            locals[:field_name] = name

            puts "HASH: #{hash.inspect}\n\n"
            puts "LOCALS: #{locals.inspect}\n\n"

            if attachment.respond_to?(:each)
              hash[:partial] = 'trestle/active_storage/has_many_field'
              locals[:attachments] = attachment
            else
              hash[:partial] = 'trestle/active_storage/has_one_field'
              locals[:attachment] = attachment
            end
          end
        end

        puts "RENDERING_OPTIONS: #{rendering_options.inspect}\n\n"
        puts "TEMPLATE #{@template.inspect}\n\n"
        puts "==========\n\n\n"
        @template.render rendering_options
      end
    end
  end
end
