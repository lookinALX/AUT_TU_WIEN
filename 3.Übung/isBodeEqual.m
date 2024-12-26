clear all;
fig = gcf;
allAxesInFigure = findall(fig,'type','axes');
ax1 = allAxesInFigure(2);
ax2 = allAxesInFigure(3);

s = tf('s');
Gs = -1 / (1 + 2 * (0.2 ...
    ) * (s / 6) + (s / 6)^2);
num = Gs.Numerator{1};
den = Gs.Denominator{1};

w = logspace(-1, 9, 300); % Ihr Frequenzbereich
[h, wout] = freqs(num, den, w);

phi = unwrap(angle(h)) * 180 / pi;
hold(ax2, "on")
semilogx(wout, 20 * log10(abs(h)), 'Parent', ax2, 'LineStyle', '--', 'Color', "#D95319")
hold(ax1, "on")
semilogx(wout, phi, 'Parent', ax1, 'LineStyle', '--', 'Color', "#D95319")