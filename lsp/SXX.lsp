(defun C:SXX (/ ent obj p1 p2 len lay ss_all ss_final i en dist cur_ang)
  (vl-load-com)
  (setvar "CMDECHO" 0)
  
  (setq ent (entsel "\n選取叉叉中的其中一個物件 (線或聚合線): "))
  
  (if ent
    (progn
      (setq en (car ent))
      (setq obj (vlax-ename->vla-object en))
      (setq lay (cdr (assoc 8 (entget en))))

      ;; 1. 使用通用函數取得起點、終點與長度
      (setq p1 (vlax-curve-getStartPoint obj)
            p2 (vlax-curve-getEndPoint obj)
            len (vlax-curve-getDistAtParam obj (vlax-curve-getEndParam obj)))

      (princ (strcat "\n正在搜尋圖層 [" lay "] 中，長度約 " (rtos len) " 且角度為 45/135 度的物件..."))

      ;; 2. 篩選：線、輕量聚合線、舊式2D聚合線
      (setq ss_all (ssget "X" (list '(0 . "LINE,LWPOLYLINE,POLYLINE") (cons 8 lay))))
      (setq ss_final (ssadd))

      (if ss_all
        (progn
          (setq i 0)
          (repeat (sslength ss_all)
            (setq en (ssname ss_all i))
            (setq obj (vlax-ename->vla-object en))
            
            ;; 取得目前物件的長度
            (setq dist (vlax-curve-getDistAtParam obj (vlax-curve-getEndParam obj)))
            
            ;; 取得角度 (以起點與終點連線計算)
            (setq cur_ang (rad2deg (angle (vlax-curve-getStartPoint obj) (vlax-curve-getEndPoint obj))))
            
            ;; 角度標準化 (0-180度)
            (while (>= cur_ang 180) (setq cur_ang (- cur_ang 180)))

            ;; 3. 嚴格比對長度與角度 (45/135度)
            ;; 這裡使用 0.001 的容差，避免浮點數運算誤差
            (if (and (equal dist len 0.001)
                     (or (equal cur_ang 45.0 0.2) 
                         (equal cur_ang 135.0 0.2)))
              (ssadd en ss_final)
            )
            (setq i (1+ i))
          )
          
          ;; 4. 亮顯結果
          (if (> (sslength ss_final) 0)
            (progn
              (sssetfirst nil ss_final)
              (princ (strcat "\n成功！已選取 " (itoa (sslength ss_final)) " 個叉叉組成物件。")))
            (princ "\n找不到符合條件的物件。")
          )
        )
      )
    )
    (princ "\n請選取物件。")
  )
  (princ)
)

;; 輔助程式：弧度轉角度
(defun rad2deg (rad) (/ (* rad 180.0) pi))