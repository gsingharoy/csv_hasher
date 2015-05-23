require 'csv'

class CSVHasher

  def self.hashify(path_to_csv)
    csv_arrs = CSV.read(path_to_csv)
    keys = col_keys(csv_arrs[0])
    csv_arrs[1..-1].map {|a| Hash[ keys.zip(a) ] }
  end

  private 

  def self.col_keys(keys)
    keys.map{ |k| k.gsub('  ',' ').gsub(' ','_').downcase.to_sym }
  end

end

