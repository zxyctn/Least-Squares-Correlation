function [A, b] = design(f, g, fx, fy, x, y)
    % 6x6 Matrix A
    A = [sum((fx^2)*(x^2),'all') sum((fx^2)*x*y,'all') sum(fx*fy*(x^2),'all') sum(fx*fy*x*y,'all') sum((fx^2)*x,'all') sum(fx*fy*x,'all');
         sum((fx^2)*x*y,'all') sum((fx^2)*(y^2),'all') sum(fx*fy*x*y,'all') sum(fx*fy*(y^2),'all') sum((fx^2)*y,'all') sum(fx*fy*y,'all');
         sum(fx*fy*(x^2),'all') sum(fx*fy*x*y,'all') sum((fy^2)*(x^2),'all') sum((fy^2)*x*y,'all') sum(fx*fy*x,'all') sum((fy^2)*x,'all');
         sum(fx*fy*x*y,'all') sum(fx*fy*(y^2),'all') sum((fy^2)*x*y,'all') sum((fy^2)*(y^2),'all') sum(fx*fy*y,'all') sum((fy^2)*y,'all');
         sum((fx^2)*x,'all') sum((fx^2)*y,'all') sum(fx*fy*x,'all') sum(fx*fy*y,'all') sum((fx^2),'all') sum(fx*fy,'all');
         sum(fx*fy*x,'all') sum(fx*fy*y,'all') sum((fy^2)*x,'all') sum((fy^2)*y,'all') sum(fx*fy,'all') sum((fy^2),'all');];
    
    % Grey value differences
    dif = f-g;
    
    fx_x = fx.*x;
    fx_y = fx.*y;
    fy_x = fy.*x;
    fy_y = fy.*y;
    
    % Observation vector b
    b = [sum(dif.*fx_x,'all') sum(dif*fx_y,'all') sum(dif.*fy_x,'all') sum(dif*fy_y,'all') sum(dif.*fx,'all') sum(dif.*fy,'all')];
end