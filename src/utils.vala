/*-
 * Copyright (c) 2015 StopClock Developers (nine.gentooman@gmail.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Library General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace StopClock {
    namespace Utils {

    public void time_to_hms (double t, out int h, out int m, out int s, out int ms) {
        double r;
        h = (int) t / 3600;
        t %= 3600;
        m = (int) t / 60;
        t %= 60;
        s = (int) t;
        r = t - s;
        ms = (int) (r * 100);
    }

    public void hms_to_double (int h, int m, int s, out double t) {
        t = s + (m * 60) + (h * 3600);
    }

    }
}
