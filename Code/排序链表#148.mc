排序链表
===
题目描述
---
给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。

进阶：

>你可以在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序吗？


代码实现
---
>归并排序
```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode sortList(ListNode head) {
        if(null == head){
            return head;
        } else if(null == head.next){
            return head;
        }
        
        //记录链表的头结点（非第一个节点）
        ListNode front = new ListNode();
        front.next = head;
        ListNode s = front.next, q = front.next.next;

        //快慢指针寻找链表中间节点
        while(null != q && null != q.next){
            s = s.next;
            q = q.next.next;
        }

        ListNode head2 = s.next;
        s.next = null;
        
        //对中间节点前后进行分解
        ListNode p1 = sortList(head);
        ListNode p2 = sortList(head2);
        ListNode sorted = front;
        
        //归并 排序
        if(p1.val <= p2.val){
            sorted.next = p1;
            p1 = p1.next;
        } else {
            sorted.next = p2;
            p2 = p2.next;
        }
        sorted = sorted.next;

        while(null != p1 && null != p2){
            if(p1.val <= p2.val){
                sorted.next = p1;
                p1 = p1.next;
                sorted = sorted.next;
            } else {
                sorted.next = p2;
                p2 = p2.next;
                sorted = sorted.next;
            }
        }

        while(null != p1){
            sorted.next = p1;
            p1 = p1.next;
            sorted = sorted.next;
        }

        while(null != p2){
            sorted.next = p2;
            p2 = p2.next;
            sorted = sorted.next;
        }

        return front.next;
    }
}
```


运行结果
---

|数据结构	|  运行时间  |  内存消耗|
|---|---|---|         
|链表| 7ms| 46.7MB|
|优于| 40.32%| 17.69%|

最快的方法使用的桶排序

内存消耗最小的方法是先遍历获取链表长度

