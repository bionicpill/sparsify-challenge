module Sparsify

  DELIMETER = ENV['SPARSIFY_DELIMETER'] || '.'

  def self.sparse(data, prefix=nil)

    result = {}

    data.each do |key, value|

      if value.is_a?(Hash)
        result.merge! sparse(value, key_name(prefix, key))
      else
        result.merge!({ key_name(prefix, key) => value })
      end

    end

    result

  end

  private

  def self.key_name(prefix, key)
    [prefix, key].compact.join(DELIMETER)
  end

end
