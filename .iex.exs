alias Deneb.{Chart, Encoding, Mark, Projection, Selection, Transform, Viewer}
encoding = %{
  color: %{condition: %{test: "datum.open < datum.close", value: "#06982d"}, value: "##ae1325"},
  x: %{
    axis: %{format: "%m/%d", lebelAngle: -45},
    field: "date",
    type: "temporal"
  },
  y: %{scale: %{zero: false}, type: "quantitative"}
}

ohlc = "date,open,high,low,close,signal,ret\n2009-06-01,28.7,30.05,28.45,30.04,short,-4.89396411092985\n2009-06-02,30.04,30.13,28.3,29.63,short,-0.322580645161295\n2009-06-03,29.62,31.79,29.62,31.02,short,3.68663594470045\n2009-06-04,31.02,31.02,29.92,30.18,short,4.51010886469673\n2009-06-05,29.39,30.81,28.85,29.62,short,6.08424336973478\n2009-06-08,30.84,31.82,26.41,29.77,short,1.2539184952978\n2009-06-09,29.77,29.77,27.79,28.27,short,-5.02431118314424\n2009-06-10,26.9,29.74,26.9,28.46,short,-5.46623794212217\n2009-06-11,27.36,28.11,26.81,28.11,short,-8.3743842364532\n2009-06-12,28.08,28.5,27.73,28.15,short,-5.52763819095477\n2009-06-15,29.7,31.09,29.64,30.81,long,3.4920634920635\n2009-06-16,30.81,32.75,30.07,32.68,short,0.155038759689914\n2009-06-17,31.19,32.77,30.64,31.54,short,5.82822085889571\n2009-06-18,31.54,31.54,29.6,30.03,short,8.17610062893082\n2009-06-19,29.16,29.32,27.56,27.99,short,8.59872611464968\n2009-06-22,30.4,32.05,30.3,31.17,short,15.4907975460123\n2009-06-23,31.3,31.54,27.83,30.58,short,11.7370892018779\n2009-06-24,30.58,30.58,28.79,29.05,long,-10.4234527687296\n2009-06-25,29.45,29.56,26.3,26.36,long,0\n2009-06-26,27.09,27.22,25.76,25.93,long,0\n2009-06-29,25.93,27.18,25.29,25.35,long,5.26315789473684\n2009-06-30,25.36,27.38,25.02,26.35,long,6.73758865248228\n2009-07-01,25.73,26.31,24.8,26.22,long,7.83645655877341\n2009-07-02,26.22,28.62,26.22,27.95,long,2.76422764227643\n2009-07-06,30.32,30.6,28.99,29,short,-2.14521452145214\n2009-07-07,29,30.94,28.9,30.85,short,3.03514376996805\n2009-07-08,30.85,33.05,30.43,31.3,short,5.68720379146919\n2009-07-09,30.23,30.49,29.28,29.78,short,8.22784810126583\n2009-07-10,29.78,30.34,28.82,29.02,short,8.64779874213836\n2009-07-13,28.36,29.24,25.42,26.31,short,7.32899022801303\n2009-07-14,26.31,26.84,24.99,25.02,short,7.30897009966778\n2009-07-15,25.05,26.06,23.83,25.89,neutral,0\n2009-07-16,25.96,26.18,24.51,25.42,long,-9.82758620689656\n2009-07-17,25.42,25.55,23.88,24.34,long,-10.8433734939759\n2009-07-20,25.06,25.42,24.26,24.4,long,-7.55711775043936\n2009-07-21,24.28,25.14,23.81,23.87,long,-2.5089605734767\n2009-07-22,24.05,24.14,23.24,23.47,long,0.915750915750916\n2009-07-23,23.71,24.05,23.21,23.43,long,2.47148288973383\n2009-07-24,23.87,23.87,23,23.09,long,4.22264875239922\n2009-07-27,24.06,24.86,24.02,24.28,long,-0.189393939393929\n2009-07-28,24.28,25.61,24.28,25.01,long,-4.37956204379562\n2009-07-29,25.47,26.18,25.41,25.61,long,-4.48504983388705\n2009-07-30,25.4,25.76,24.85,25.4,long,-1.70357751277683\n2009-07-31,25.4,26.22,24.93,25.92,short,5.06756756756757\n"


chart1 = Chart.new(Mark.new(:rule), Encoding.new(%{y: %{field: "low"}, y2: %{field: "high"}}))
chart2 = Chart.new(Mark.new(:bar), Encoding.new(%{y: %{field: "open"}, y2: %{field: "close"}}))
chart = Chart.layer([chart1, chart2], [encoding: encoding, width: 800, height: 600])
spec = Deneb.to_json(chart, ohlc)
