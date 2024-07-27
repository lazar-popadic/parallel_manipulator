function [control,err_sum,err_dif, err_prev] = pid_calc(err,Kp,Ki,Kd, err_sum, err_dif, err_prev, limit, sum_limit)
err_sum = err_sum + err;
err_sum = saturation(err_sum, +sum_limit, -sum_limit);

control = err * Kp + err_sum*Ki + err_dif*Kd;
control = saturation(control, +limit, -limit);

err_dif = err - err_prev;
err_prev = err;
end