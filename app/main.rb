database_file_path = ARGV[0]
command = ARGV[1]

if command == ".dbinfo"
  File.open(database_file_path, "rb") do |database_file|
    database_file.seek(16)  # Skip the first 16 bytes of the header
    page_size = database_file.read(2).unpack("n")[0]
    puts "database page size: #{page_size}"

    database_file.seek(26)
    number_of_tables = database_file.read(4).unpack("n")[0]
    puts "number of tables: #{number_of_tables}"
  end
end
