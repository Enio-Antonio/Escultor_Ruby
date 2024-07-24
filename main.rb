require_relative 'sculptor.rb'

objeto = Sculptor.new 8, 8, 8

objeto.set_color 0.0, 0.86, 0.0, 1.0

objeto.put_box 0, 7, 0, 7, 0, 7
objeto.cut_box 1, 6, 1, 6, 1, 6
objeto.set_color 0, 0, 0, 1.0

objeto.put_voxel 1, 4, 7
objeto.put_voxel 1, 5, 7
objeto.put_voxel 2, 4, 7
objeto.put_voxel 2, 5, 7

objeto.put_voxel 5, 4, 7
objeto.put_voxel 5, 5, 7
objeto.put_voxel 6, 4, 7
objeto.put_voxel 6, 5, 7

objeto.put_voxel 3, 3, 7
objeto.put_voxel 4, 3, 7

objeto.put_voxel 2, 2, 7
objeto.put_voxel 3, 2, 7
objeto.put_voxel 4, 2, 7
objeto.put_voxel 5, 2, 7

objeto.put_voxel 2, 1, 7
objeto.put_voxel 3, 1, 7
objeto.put_voxel 4, 1, 7
objeto.put_voxel 5, 1, 7

objeto.put_voxel 2, 0, 7
objeto.put_voxel 5, 0, 7

objeto.write_OFF "ruby_created.off"
