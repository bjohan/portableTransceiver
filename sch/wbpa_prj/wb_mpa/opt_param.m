of = [0.5e9 1e9 1.5e9 2.5e9 3.5e9];
zl = [20+5.2j, 17.6+6.66j, 16.8+3.2j, 8.02+4.32j, 5.85-0.51j];
zs = [7.75+15.5j, 3.11+5.72j, 2.86+1.63j, 2.4-3.52j, 1.31-7.3j];
zro = of./of;
sm = zeros(1,1,length(of));
sm(1,1,:) = zs;
lm = zeros(1,1,length(of));
lm(1,1,:) = zl;
%plot(real(zl), imag(zl), real(zs), imag(zs));
write_touchstone('z', of, sm, 'source_opt.s1p', 1, 'optimized zs for cgh40025')
write_touchstone('z', of, lm, 'load_opt.s1p', 1, 'optimized zl for cgh40025')