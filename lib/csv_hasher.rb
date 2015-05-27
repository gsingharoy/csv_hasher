require 'csv'

class CSVHasher

  # get arrays of hashes from a CSV file instead of arrays of arrays
  #
  # Example:
  #   >> CSVHasher.hashify('path/to/csv/file')
  #   => [{:col_1=> '..', :col_2=> '..'},...]
  #
  #
  # Arguments:
  #   path_to_csv: (String)
  #   options: (Hash)
  #            original_col_as_keys: (Boolean)
  #                                   if original_col_as_keys is true then keys are exactly the col headers
  #                                   if original_col_as_keys is false then keys are spidercase symbols from col headers
  #            keys: (Array) Custom keys for the returned hashes
  #
  #
  def self.hashify(path_to_csv, options = { original_col_as_keys: false })
    csv_arrs = CSV.read(path_to_csv)
    keys = csv_keys options, csv_arrs
    start_index = options[:keys].nil? || options[:include_headers] ? 1 : 0
    csv_arrs[start_index..-1].map {|a| Hash[keys.zip(a)] }
  end

  private

  #This method gets the csv_keys based on the options and csv_arrs
  def self.csv_keys(options, csv_arrs)
    if options[:keys]
      options[:keys]
    elsif options[:original_col_as_keys]
      csv_arrs[0]
    else
      col_keys(csv_arrs[0])
    end
  end

  # this method converts the header of the CSV into an array of sym keys
  def self.col_keys(keys)
    keys.map{ |k| k.gsub('  ',' ').gsub(' ','_').downcase.to_sym }
  end

end


