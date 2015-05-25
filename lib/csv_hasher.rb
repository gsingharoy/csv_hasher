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
  def self.hashify(path_to_csv, options = {}) 
    csv_arrs = CSV.read(path_to_csv)
    keys = options[:keys] || col_keys(csv_arrs[0])
    start_index = options[:keys].nil? || options[:include_headers] ? 1 : 0 
    csv_arrs[start_index..-1].map {|a| Hash[keys.zip(a)] }
  end

  private 

  # this method converts the header of the CSV into an array of sym keys 
  def self.col_keys(keys)
    keys.map{ |k| k.gsub('  ',' ').gsub(' ','_').downcase.to_sym }
  end

end


