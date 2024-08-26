function output = my_simplify(expr)

[numerator, denominator] = numden(expr);
denom_coeff = double(coeffs(denominator, 'All'));
output = vpa(numerator / denom_coeff(1), 2) / vpa(denominator / denom_coeff(1), 2);
end