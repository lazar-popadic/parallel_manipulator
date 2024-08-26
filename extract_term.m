function output = extract_term(expr, term)

[coeffs_1, ~] = coeffs(expr, term);
expr_1 = simplify(coeffs_1(1));
output = my_simplify(expr_1);
end