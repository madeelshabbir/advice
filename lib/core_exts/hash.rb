# frozen_string_literal: true

class Hash
  def convert_to_object
    RecursiveOpenStruct.new(self, recurse_over_arrays: true)
  end
end
