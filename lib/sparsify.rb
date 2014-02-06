module Sparsify

  DELIMETER = '.'

  def self.sparse(data, options={})
    _sparse(data, nil, options.fetch(:separator, DELIMETER))
  end

  def self.unsparse(data, options={})
    _unsparse(data, options.fetch(:separator, DELIMETER))
  end

  private

  def self._sparse(data, prefix, delimeter)

    result = {}

    data.each do |key, value|

      key_name = key_name_for(prefix, key, delimeter)

      if value.is_a?(Hash) && !value.empty?
        result.merge! _sparse(value, key_name, delimeter)
      else
        result.merge!({ key_name => value })
      end

    end

    result

  end

  def self._unsparse(data, delimeter)

    result = {}

    data.each do |key, value|
      names = key.split(delimeter)
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

  def self.key_name_for(prefix, key, delimeter)
    [prefix, key].compact.join(delimeter)
  end

end
