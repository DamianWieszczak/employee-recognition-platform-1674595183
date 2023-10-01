class ImportCsvService
  require 'csv'
  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: ';' }
    csv.foreach(opened_file, **options) do |row|
      reward = Reward.find_or_initialize_by(title: row['Title'])
      reward.description = row['Description']
      reward.category = Category.find_or_create_by!(title: row['Category'])
      reward.price = row['Price']
      reward.save!
    end
  end
end
