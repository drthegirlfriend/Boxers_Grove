within Functions;

block Rad_to_Deg "Converts Radians to Degrees"
  extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "rad"), y(unit = "deg"));
equation
  y = Modelica.SIunits.Conversions.to_deg(u);
  annotation(Diagram(coordinateSystem(extent = {{-150, -90}, {150, 90}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(visible = true, textColor = {64, 64, 64}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), Polygon(visible = true, lineColor = {190, 20, 31}, fillColor = {190, 20, 31}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-60, 5}, {42.5, 5}, {27.5, 20}, {40, 20}, {60, 0}, {40, -20}, {27.5, -20}, {42.5, -5}, {-60, -5}}), Text(visible = true, textColor = {64, 64, 64}, extent = {{-90, 40}, {90, 90}}, textString = "Rad", horizontalAlignment = TextAlignment.Left), Text(visible = true, textColor = {64, 64, 64}, extent = {{-90, -90}, {90, -40}}, textString = "Deg", horizontalAlignment = TextAlignment.Right)}));
end Rad_to_Deg;
