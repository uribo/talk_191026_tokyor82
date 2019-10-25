# reticulate::repl_python()
# ソースファイル中、カーソルのある行をreturnで実行
import matplotlib.pyplot as plt
import geopandas
geopandas.__version__

world = geopandas.read_file(geopandas.datasets.get_path('naturalearth_lowres'))
word_crs = world.crs
# world.plot()
# plt.show()
# plt.close()

from shapely.geometry import Point, LineString, Polygon
point = Point(1, 1)
line = LineString([(0, 0), (1, 2), (2, 2)])
poly = line.buffer(1)
poly.contains(point)
