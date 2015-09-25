/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd
** All rights reserved.
** For any questions to The Qt Company, please use contact form at http://qt.io
**
** This file is part of the Qt Charts module.
**
** Licensees holding valid commercial license for Qt may use this file in
** accordance with the Qt License Agreement provided with the Software
** or, alternatively, in accordance with the terms contained in a written
** agreement between you and The Qt Company.
**
** If you have questions regarding the use of this file, please use
** contact form at http://qt.io
**
****************************************************************************/

import QtQuick 2.0
import QtTest 1.0
import QtCharts 2.0

Rectangle {
    width: 400
    height: 300

    TestCase {
        id: tc1
        name: "tst_qml-qtquicktest BoxPlotSeries 2.0"
        when: windowShown

        function test_properties() {
            compare(boxPlotSeries.boxWidth, 0.5);
            compare(boxPlotSeries.brushFilename, "");
        }

        function test_setproperties() {
            var set = boxPlotSeries.append("boxplot", [1, 2, 5, 6, 8]);
            compare(set.label, "boxplot");
            compare(set.count, 5);
            compare(set.brushFilename, "");
        }

        function test_append() {
            boxPlotSeries.clear();
            addedSpy.clear();
            countChangedSpy.clear();
            var count = 50;
            for (var i = 0; i < count; i++)
                boxPlotSeries.append("boxplot" + i, Math.random());
            compare(addedSpy.count, count);
            compare(countChangedSpy.count, count);
            compare(boxPlotSeries.count, count)
            boxPlotSeries.clear();
        }

        function test_remove() {
            boxPlotSeries.clear();
            removedSpy.clear();
            countChangedSpy.clear();
            var count = 50;
            for (var i = 0; i < count; i++)
                boxPlotSeries.append("boxplot" + i, Math.random());
            for (var j = 0; j < count; j++)
                boxPlotSeries.remove(boxPlotSeries.at(0));
            compare(removedSpy.count, count);
            compare(countChangedSpy.count, 2 * count);
            compare(boxPlotSeries.count, 0)
        }
    }

    ChartView {
        id: chartView
        anchors.fill: parent

        BoxPlotSeries {
            id: boxPlotSeries
            name: "boxplot"
            BoxSet { label: "Jan"; values: [3, 4, 5.1, 6.2, 8.5] }

            SignalSpy {
                id: addedSpy
                target: boxPlotSeries
                signalName: "boxsetsAdded"
            }
            SignalSpy {
                id: removedSpy
                target: boxPlotSeries
                signalName: "boxsetsRemoved"
            }
            SignalSpy {
                id: countChangedSpy
                target: boxPlotSeries
                signalName: "countChanged"
            }
        }
    }
}
