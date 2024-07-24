require_relative 'voxel.rb'

class Sculptor
    def initialize nx, ny, nz
        @nx = nx
        @ny = ny
        @nz = nz

        @r = 0.0
        @g = 0.0
        @b = 0.0
        @a = 0.0

        @v = Array.new(@nx) {Array.new(@ny) {Array.new(@nz)}}

        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    @v[i][c][k] = Voxel.new 0.0, 0.0, 0.0, 0.0, false
                end
            end
        end
    end

    def set_color r, g, b, a
        @r = r 
        @g = g
        @b = b
        @a = a
    end

    def put_voxel x, y, z
        @v[x][y][z].show= true
        @v[x][y][z].r= @r
        @v[x][y][z].g= @g
        @v[x][y][z].b= @b
        @v[x][y][z].a= @a
    end

    def put_box x0, x1, y0, y1, z0, z1
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if (i >= x0 && i <= x1) && (c >= y0 && c <= y1) && (k >= z0 && k <= z1) then
                        @v[i][c][k].show= true
                        @v[i][c][k].r= @r
                        @v[i][c][k].g= @g
                        @v[i][c][k].b= @b
                        @v[i][c][k].a= @a
                    end
                end
            end
        end
    end

    def cut_box x0, x1, y0, y1, z0, z1
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if (i >= x0 && i <= x1) && (c >= y0 && c <= y1) && (k >= z0 && k <= z1) then
                        @v[i][c][k].show= false
                    end
                end
            end
        end
    end

    def put_sphere xcenter, ycenter, zcenter, radius
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if (i - xcenter) * (i - xcenter) +
                        (c - ycenter) * (c - ycenter) +
                        (k - zcenter) * (k - zcenter) <= radius * radius then
                        @v[i][c][k].show= true
                        @v[i][c][k].r= @r
                        @v[i][c][k].g= @g
                        @v[i][c][k].b= @b
                        @v[i][c][k].a= @a
                    end
                end
            end
        end
    end

    def cut_sphere xcenter, ycenter, zcenter, radius
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if (i - xcenter) * (i - xcenter) +
                        (c - ycenter) * (c - ycenter) +
                        (k - zcenter) * (k - zcenter) <= radius * radius then
                        @v[i][c][k].show= false
                    end
                end
            end
        end
    end

    def put_ellipsoid xcenter, ycenter, zcenter, rx, ry, rz
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if ((i - xcenter) * (i - xcenter)) / (rx.to_f * rx) +
                        ((c - ycenter) * (c - ycenter)) / (ry.to_f * ry) +
                        ((k - zcenter) * (k - zcenter)) / (rz.to_f * rz) <= 1 then
                        @v[i][c][k].show= true
                        @v[i][c][k].r= @r
                        @v[i][c][k].g= @g
                        @v[i][c][k].b= @b
                        @v[i][c][k].a= @a
                    end
                end
            end
        end
    end

    def cut_ellipsoid xcenter, ycenter, zcenter, rx, ry, rz
        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if ((i - xcenter) * (i - xcenter)) / (rx.to_f * rx) +
                        ((c - ycenter) * (c - ycenter)) / (ry.to_f * ry) +
                        ((k - zcenter) * (k - zcenter)) / (rz.to_f * rz) <= 1 then
                        @v[i][c][k].show = false
                    end
                end
            end
        end
    end

    def write_OFF filename
        contador_vox = 0

        aux_v1 = 0
        aux_v2 = 1
        aux_v3 = 2
        aux_v4 = 3
        aux_v5 = 4
        aux_v6 = 5
        aux_v7 = 6
        aux_v8 = 7

        soma8 = 0

        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if @v[i][c][k].show == true then
                        contador_vox += 1
                    end
                end
            end
        end

        n_vertices = contador_vox * 8
        n_faces = contador_vox * 6

        sculptor_writer = open filename, 'w'

        sculptor_writer.write "OFF\n#{n_vertices} #{n_faces} 0\n"

        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if @v[i][c][k].show == true then
                          sculptor_writer.write "#{i - 1} #{c} #{k - 1}\n"
                          sculptor_writer.write "#{i - 1} #{c - 1} #{k - 1}\n"
                          sculptor_writer.write "#{i} #{c - 1} #{k - 1}\n"
                          sculptor_writer.write "#{i} #{c}  #{k - 1}\n"
                          sculptor_writer.write "#{i - 1} #{c} #{k}\n"
                          sculptor_writer.write "#{i - 1} #{c - 1} #{k}\n"
                          sculptor_writer.write "#{i} #{c - 1} #{k}\n"
                          sculptor_writer.write "#{i} #{c} #{k}\n"
                    end
                end
            end
        end

        for i in 0..(@nx - 1) do
            for c in 0..(@ny - 1) do
                for k in 0..(@nz - 1) do
                    if (@v[i][c][k].show == true) then
                        sculptor_writer.write "4 #{aux_v1 + soma8} #{aux_v4 + soma8} #{aux_v3 + soma8} #{aux_v2 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        sculptor_writer.write "4 #{aux_v5 + soma8} #{aux_v6 + soma8} #{aux_v7 + soma8} #{aux_v8 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        sculptor_writer.write "4 #{aux_v1 + soma8} #{aux_v2 + soma8} #{aux_v6 + soma8} #{aux_v5 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        sculptor_writer.write "4 #{aux_v1 + soma8} #{aux_v5 + soma8} #{aux_v8 + soma8} #{aux_v4 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        sculptor_writer.write "4 #{aux_v4 + soma8} #{aux_v8 + soma8} #{aux_v7 + soma8} #{aux_v3 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        sculptor_writer.write "4 #{aux_v2 + soma8} #{aux_v3 + soma8} #{aux_v7 + soma8} #{aux_v6 + soma8} #{@v[i][c][k].r} #{@v[i][c][k].g} #{@v[i][c][k].b} #{@v[i][c][k].a} \n"

                        soma8 += 8
                    end
                end
            end
        end

    sculptor_writer.close
    end

end