module Sparsify

  DELIMETER = ENV['SPARSIFY_DELIMETER'] || '.'

  def self.sparse(data, options={})
    @@delimeter = options.fetch(:separator, DELIMETER)
    _sparse(data)
  end

  def self.unsparse(data, options={})
    @@delimeter = options.fetch(:separator, DELIMETER)
    _unsparse(data)
  end

  private

  def self._sparse(data, prefix=nil)

    result = {}

    data.each do |key, value|

      if value.is_a?(Hash) && !value.empty?
        result.merge! _sparse(value, key_name(prefix, key))
      else
        result.merge!({ key_name(prefix, key) => value })
      end

    end

    result

  end

  def self._unsparse(data)

    result = {}

    data.each do |key, value|
      names = key.split(@@delimeter)
      last_key = names.pop

      current = result
      names.each do |name|
        current[name] ||= {}
        current = current[name]
      end
      current[last_key] = value
    end

    result

  end

  def self.key_name(prefix, key)
    [prefix, key].compact.join(@@delimeter)
  end

end
