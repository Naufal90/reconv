import os
import struct

def extract_dat(file_path, output_dir):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    with open(file_path, 'rb') as dat_file:
        file_size = os.path.getsize(file_path)
        current_offset = 0

        while current_offset < file_size:
            dat_file.seek(current_offset)

            # Assuming the structure: [4 bytes for filename length] [filename] [4 bytes for file size] [file content]
            filename_len = struct.unpack('<I', dat_file.read(4))[0]
            filename = dat_file.read(filename_len).decode('utf-8')
            file_size = struct.unpack('<I', dat_file.read(4))[0]
            file_data = dat_file.read(file_size)

            output_file_path = os.path.join(output_dir, filename)
            with open(output_file_path, 'wb') as output_file:
                output_file.write(file_data)

            current_offset += 4 + filename_len + 4 + file_size

if __name__ == "__main__":
    dat_file_path = "path/to/your/datfile.dat"
    output_directory = "path/to/output/directory"
    extract_dat(dat_file_path, output_directory)
