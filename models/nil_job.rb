module System
  class NilJob
    attr_reader :name, :dependency

    def nil?
      true
    end

  end
end