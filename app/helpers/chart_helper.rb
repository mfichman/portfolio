module ChartHelper
  def percent(value, total)
    "#{(value / total * 100).round}%"
  end

  def legend(labels)
    capture do
      labels.each_with_index do |label, n|
        yield label, n
      end
    end
  end

  def line(values)
    y_max = values.max
    y_min = values.min
    y_scale = y_max - y_min

    y_min = y_min - 0.1 * y_scale
    y_scale = 1.2 * y_scale

    x_max = values.count.to_f
    x_min = 0
    x_scale = x_max - x_min

    chart = Rasem::SVGImage.new(class: 'chart-image', preserveAspectRatio: 'none', viewBox: '0 0 1 1') do
      path(class: "chart-fill-color-1") do
        moveToA(0, 1)
        lineToA(x_min, 1 - (values.first - y_min) / y_scale)
        values.each_with_index do |value, n|
          lineToA((n - x_min) / x_scale, 1 - (value - y_min) / y_scale)
        end
        lineToA(x_max, 1)
      end
    end

    chart.to_s.html_safe
  end

  def pie(values)
    total = values.sum
    pos = 0

    chart = Rasem::SVGImage.new(class: 'chart-image', viewBox: '-1 -1 2 2') do
      values.each_with_index do |value, n|
        path(class: "chart-fill-color-#{n}") do
          sector = 2 * Math::PI * (value / total)
          sx, sy = Math::cos(pos), Math::sin(pos)
          pos += sector
          ex, ey = Math::cos(pos), Math::sin(pos)

          large_arc = sector > Math::PI ? 1 : 0

          moveToA(0, 0)
          lineToA(sx, sy)
          arcToA(ex, ey, 1, 1, 0, large_arc, 1)
        end
      end
    end

    chart.to_s.html_safe
  end
end
