module Application
  module Models
    class Dictionary
      attr_reader :dictionary

      def initialize
        @dictionary = JSON.parse File.read(file_path)
      end

      def self.all
        new.dictionary
      end

      private

      def file_path
        File.join(__dir__, '..', '..', 'config', 'dictionary.json')
      end
    end
  end
end
