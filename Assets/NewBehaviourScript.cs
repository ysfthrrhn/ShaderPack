using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    public Animator animator;

    public void ActivateAnimator()
    {
        animator.enabled = true;
    }
}
