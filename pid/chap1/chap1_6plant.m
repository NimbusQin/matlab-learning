function dy = PlantModel(t, y, flag, para)
u = para;
j = 0.0067;
b = 0.1;

dy = zeros(2, 1);
dy(1) = y(2);
dy(2) = -(b/j)*dy(2) + (1/j)*u;