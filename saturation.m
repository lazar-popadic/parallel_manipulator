function [out] = saturation(signal, limit_h, limit_l)
if signal > limit_h
    out = limit_h;
elseif signal < limit_l
    out = limit_l;
else
    out = signal;
end