"use client";

import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useTheme } from './ThemeProvider';

interface PriceHistoryChartProps {
  data: {
    date: string;
    price: number;
    currency: string;
  }[];
}

export function PriceHistoryChart({ data }: PriceHistoryChartProps) {
  const { isDark } = useTheme();

  if (!data || data.length < 2) {
    return (
      <div className="flex flex-col items-center justify-center py-12 bg-muted/20 rounded-xl border border-dashed border-border transition-colors duration-300">
        <p className="text-muted-foreground font-bold text-sm">Not enough data</p>
        <p className="text-xs text-muted-foreground/75 mt-0.5">We need at least two price records to show a trend.</p>
      </div>
    );
  }

  // Coordinate chart visual colors dynamically based on theme
  const strokeColor = isDark ? '#14A3A8' : '#0D7377';       // Teal colors
  const gridColor = isDark ? 'rgba(255, 255, 255, 0.08)' : '#E2E8F0';
  const tickColor = isDark ? '#94A3B8' : '#64748B';          // Label text
  const dotColor = isDark ? '#14A3A8' : '#0D7377';
  const activeDotColor = isDark ? '#E2B654' : '#D4A843';     // Accent Gold
  const tooltipBg = isDark ? '#1E293B' : '#FFFFFF';
  const tooltipBorder = isDark ? '#2E384C' : '#E2E8F0';
  const tooltipTextColor = isDark ? '#F8FAFC' : '#1E293B';

  return (
    <div className="w-full h-[300px] transition-colors duration-300">
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ top: 5, right: 20, left: -20, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" vertical={false} stroke={gridColor} />
          <XAxis 
            dataKey="date" 
            tickLine={false} 
            axisLine={false}
            tick={{ fill: tickColor, fontSize: 11, fontWeight: 500 }}
            dy={10}
          />
          <YAxis 
            tickLine={false} 
            axisLine={false} 
            tick={{ fill: tickColor, fontSize: 11, fontWeight: 500 }}
            dx={-10}
            tickFormatter={(value) => `Rs ${value}`}
          />
          <Tooltip
            contentStyle={{ 
              borderRadius: '8px', 
              border: `1px solid ${tooltipBorder}`, 
              backgroundColor: tooltipBg,
              color: tooltipTextColor,
              boxShadow: '0 4px 12px -2px rgb(0 0 0 / 0.12)',
              fontSize: '12px',
              fontWeight: 600
            }}
            formatter={(value: any) => [`Rs ${value}`, 'Price']}
            labelStyle={{ color: tickColor, marginBottom: '4px', fontSize: '11px' }}
          />
          <Line 
            type="monotone" 
            dataKey="price" 
            stroke={strokeColor} 
            strokeWidth={3}
            dot={{ r: 4, fill: dotColor, strokeWidth: 0 }}
            activeDot={{ r: 6, fill: activeDotColor, stroke: isDark ? '#1E293B' : '#fff', strokeWidth: 2 }}
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}
