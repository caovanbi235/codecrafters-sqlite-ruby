database_file_path = ARGV[0]
command = ARGV[1]

case command
when ".dbinfo"
  File.open(database_file_path, "rb") do |database_file|
    database_file.seek(16) # Skip the first 16 bytes of the header
    @page_size = database_file.read(2).unpack1("n").to_i
    puts "database page size: #{@page_size}"

    database_file.seek(26)
    number_of_tables = database_file.read(4).unpack("n")[0]
    puts "number of tables: #{number_of_tables}"
  end

when ".tables"
  File.open(database_file_path, "rb") do |database_file|
    database_file.seek(100)
    page_header = database_file.read(@page_size)
    regex = /CREATE TABLE (?!sqlite_)(\w+)/
    tables = page_header.scan(regex).map { |element|
      element[0].gsub('CREATE TABLE', '').strip
    }.reverse
    puts tables
  end
end

